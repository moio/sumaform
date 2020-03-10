#!{{grains['pythonexecutable']}}

import base64
import http.client
import json
import re
import sys

def find_next_path(resp):
  link = resp.getheader("Link")
  if link is not None:
    regex = re.compile(r'<https://scc.suse.com([^>]+)>; rel="next"')
    match = regex.search(link)
    if match is not None:
        return match.group(1)

def get_paginated(connection, headers, path):
  result = []
  current_path = path
  while current_path is not None:
    connection.request("GET", current_path, headers=headers)
    resp = connection.getresponse()
    content = resp.read()

    if resp.status != 200:
        print("Unexpected HTTP status received on %s: %d" % (current_path, resp.status))
        sys.exit(1)

    result.extend(json.loads(content))
    current_path = find_next_path(resp)
  return result

def save_json(content, path):
  with open(path, 'w') as out_file:
    json.dump(content, out_file, sort_keys=True, indent=4)

if len(sys.argv) != 2:
    print("USAGE: refresh_scc_data.py SCC_USERNAME:SCC_PASS")

connection = http.client.HTTPSConnection("scc.suse.com")
token = base64.b64encode(sys.argv[1].encode("ASCII")).decode("ascii")
headers = { 'Authorization' : 'Basic %s' %  token }

products = get_paginated(connection, headers, "/connect/organizations/products/unscoped")
save_json(products, "organizations_products_unscoped.json")
print("organizations_products_unscoped.json refreshed")

repositories = get_paginated(connection, headers, "/connect/organizations/repositories")
save_json(repositories, "organizations_repositories.json")
print("organizations_repositories.json refreshed")

subscriptions = get_paginated(connection, headers, "/connect/organizations/subscriptions")
save_json(subscriptions, "organizations_subscriptions.json")
print("organizations_subscriptions.json refreshed")

orders = get_paginated(connection, headers, "/connect/organizations/orders")
save_json(orders, "organizations_orders.json")
print("organizations_orders.json refreshed")

product_tree = get_paginated(connection, headers, "/suma/product_tree.json")
save_json(product_tree, "product_tree.json")
print("product_tree.json refreshed")

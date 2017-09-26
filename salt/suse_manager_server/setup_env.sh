MANAGER_USER="spacewalk"
MANAGER_PASS="spacewalk"
MANAGER_ADMIN_EMAIL="galaxy-noise@suse.de"
CERT_O="SUSE"
CERT_OU="SUSE"
CERT_CITY="Nuernberg"
CERT_STATE="Bayern"
CERT_COUNTRY="DE"
CERT_EMAIL="galaxy-noise@suse.de"
CERT_PASS="spacewalk"
USE_EXISTING_CERTS="N"
{% if grains['database'] == 'pgpool' %}
LOCAL_DB=0
{% endif %}
MANAGER_DB_NAME="susemanager"
MANAGER_DB_HOST="localhost"
MANAGER_DB_PORT="5432"
MANAGER_DB_PROTOCOL="TCP"
MANAGER_ENABLE_TFTP="Y"
{% if '2.1' in grains['version'] %}
NCC_USER="{{ grains.get("cc_username") }}"
NCC_PASS="{{ grains.get("cc_password") }}"
NCC_EMAIL="galaxy-noise@suse.de"
{% else %}
SCC_USER="{{ grains.get("cc_username") }}"
SCC_PASS="{{ grains.get("cc_password") }}"
{% endif %}

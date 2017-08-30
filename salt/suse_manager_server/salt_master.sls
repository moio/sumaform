{% if '2.1' not in grains['version'] and grains.get('auto_accept') %}

include:
  - suse_manager_server

custom_salt_master_configuration:
  file.managed:
    - name: /etc/salt/master.d/custom.conf
    - contents: |
        auto_accept: True
    - require:
        - sls: suse_manager_server

salt_master:
  service.running:
    - name: salt-master
    - enable: True
    - watch:
      - file: custom_salt_master_configuration
{% endif %}

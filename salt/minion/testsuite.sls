{% if grains.get('testsuite') | default(false, true) %}

include:
  - minion

minion_cucumber_requisites:
  pkg.installed:
    - pkgs:
      - salt-minion
      - openscap-utils
    - require:
      - sls: default

{% if grains['os'] == 'SUSE' %}

{% if '12' in grains['osrelease'] %}
containers_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Module-Containers-SLE-12-x86_64-Pool.repo
    - source: salt://minion/repos.d/SLE-Module-Containers-SLE-12-x86_64-Pool.repo
    - template: jinja

containers_updates_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Module-Containers-SLE-12-x86_64-Update.repo
    - source: salt://minion/repos.d/SLE-Module-Containers-SLE-12-x86_64-Update.repo
    - template: jinja
{% endif %}

{% if '15' in grains['osrelease'] %}
containers_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Module-Containers-SLE-15-x86_64-Pool.repo
    - source: salt://minion/repos.d/SLE-Module-Containers-SLE-15-x86_64-Pool.repo
    - template: jinja

containers_updates_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Module-Containers-SLE-15-x86_64-Update.repo
    - source: salt://minion/repos.d/SLE-Module-Containers-SLE-15-x86_64-Update.repo
    - template: jinja
{% endif %}

refresh_minion_repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    {% if '12' in grains['osrelease'] or '15' in grains['osrelease'] %}
    - require:
      - file: containers_pool_repo
      - file: containers_updates_repo
    {% endif %}

suse_minion_cucumber_requisites:
  pkg.installed:
    - pkgs:
      - openscap-content
      {% if '12' in grains['osrelease'] or '15' in grains['osrelease']%}
      - aaa_base-extras
      - ca-certificates
      {% endif %}
    - require:
      - cmd: refresh_minion_repos

{% if '12' in grains['osrelease'] or '15' in grains['osrelease'] %}
registry_certificate:
  file.managed:
    - name: /etc/pki/trust/anchors/registry.mgr.suse.de.pem
    - source: salt://minion/certs/registry.mgr.suse.de.pem
    - makedirs: True

portus_registry_certificate:
  file.managed:
    - name: /etc/pki/trust/anchors/portus.mgr.suse.de-ca.crt
    - source: salt://minion/certs/portus.mgr.suse.de-ca.crt
    - makedirs: True

suse_certificate:
  file.managed:
    - name: /etc/pki/trust/anchors/SUSE_Trust_Root.crt.pem
    - source: salt://minion/certs/SUSE_Trust_Root.crt.pem
    - makedirs: True

update_ca_truststore:
  cmd.wait:
    - name: /usr/sbin/update-ca-certificates
    - watch:
      - file: registry_certificate
      - file: suse_certificate
    - require:
      - pkg: suse_minion_cucumber_requisites

{% endif %}

{% endif %}

{% endif %}

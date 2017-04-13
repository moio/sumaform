{% if grains['os'] == 'SUSE' %}

{% if grains['osrelease'] == '42.2' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.2-Pool.repo
    - source: salt://default/repos.d/openSUSE-Leap-42.2-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.2-Update.repo
    - source: salt://default/repos.d/openSUSE-Leap-42.2-Update.repo
    - template: jinja

tools_pool_repo:
  file.touch:
    - name: /tmp/no_tools_pool_channel_needed

tools_update_repo:
  file.touch:
    - name: /tmp/no_tools_update_channel_needed
{% endif %}


{% if '11' in grains['osrelease'] %}
{% if grains['osrelease'] == '11.3' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP3-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-11-SP3-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP3-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-11-SP3-x86_64-Update.repo
    - template: jinja
{% elif grains['osrelease'] == '11.4' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-11-SP4-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-11-SP4-x86_64-Update.repo
    - template: jinja
{% endif %}

{% if 'head' in grains.get('version', '') or '3.1-stable' in grains.get('version', '') %}
tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - template: jinja

tools_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-11-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-11-x86_64.repo
    - template: jinja
{% elif 'nightly' in grains.get('version', '') %}
tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - template: jinja

tools_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_3.0_SLE-Manager-Tools-11-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.0_SLE-Manager-Tools-11-x86_64.repo
    - template: jinja
{% elif 'stable' in grains.get('version', 'stable') %}
tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - template: jinja

tools_update_repo:
  file.touch:
    - name: /tmp/no_tools_update_channel_needed
{% endif %}

{% endif %}



{% if '12' in grains['osrelease'] %}
{% if grains['osrelease'] == '12' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-x86_64-Update.repo
    - template: jinja
{% elif grains['osrelease'] == '12.1' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-SP1-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-SP1-x86_64-Update.repo
    - template: jinja
{% elif grains['osrelease'] == '12.2' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-SP2-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-SP2-x86_64-Update.repo
    - template: jinja
{% endif %}

{% if 'head' in grains.get('version', '') or '3.1-stable' in grains.get('version', '') %}
tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-12-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-12-x86_64.repo
    - template: jinja

tools_update_repo:
  file.touch:
    - name: /tmp/no_tools_update_channel_needed
{% elif 'nightly' in grains.get('version', '') %}
tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_3.0_SLE-Manager-Tools-12-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.0_SLE-Manager-Tools-12-x86_64.repo
    - template: jinja

tools_update_repo:
  file.touch:
    - name: /tmp/no_tools_update_channel_needed
{% elif 'stable' in grains.get('version', 'stable') %}
tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Pool.repo
    - template: jinja

tools_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Update.repo
    - template: jinja
{% endif %}
{% endif %}

allow_vendor_changes:
  file.managed:
    - name: /etc/zypp/vendors.d/suse
    - makedirs: True
    - contents: |
        [main]
        vendors = SUSE,obs://build.suse.de/Devel:Galaxy,openSUSE Build Service

refresh_default_repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - require:
      - file: os_pool_repo
      - file: os_update_repo
      - file: tools_pool_repo
      - file: tools_update_repo
{% endif %}

{% if grains['os_family'] == 'RedHat' %}

galaxy_key:
  file.managed:
    - name: /tmp/galaxy.key
    - source: salt://default/galaxy.key
  cmd.wait:
    - name: rpm --import /tmp/galaxy.key
    - watch:
      - file: galaxy_key

{% if grains['osmajorrelease'] == '7' %}
{% if 'head' in grains.get('version', '') or '3.1-stable' in grains.get('version', '') %}
tools_repo:
  file.managed:
    - name: /etc/yum.repos.d/Devel_Galaxy_Manager_Head_RES-Manager-Tools-7-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_RES-Manager-Tools-7-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key
{% elif 'nightly' in grains.get('version', '') %}
tools_repo:
  file.managed:
    - name: /etc/yum.repos.d/Devel_Galaxy_Manager_3.0_RES-Manager-Tools-7-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.0_RES-Manager-Tools-7-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key
{% elif 'stable' in grains.get('version', 'stable') %}
tools_repo:
  file.managed:
    - name: /etc/yum.repos.d/SLE-Manager-Tools-RES-7-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-RES-7-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key
{% endif %}
{% endif %}

{% endif %}

{% for label, url in grains['additional_repos'].items() %}
{{ label }}_repo:
  pkgrepo.managed:
    - humanname: {{ label }}
    - baseurl: {{ url }}
    - priority: 98
    - gpgcheck: 0
{% endfor %}

default_repos:
  test.nop: []

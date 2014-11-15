{% from "supervisor/map.jinja" import supervisor, supervisor_config with context %}

include:
  - supervisor
  - supervisor.conf

# TODO: allow customization inside scripts (service name, config file)
supervisor-start-script-systemd:
  file.managed:
    - name: /usr/lib/systemd/system/supervisor.service
    - source: salt://supervisor/files/supervisor.systemd
    - onlyif:
      - test -d /usr/lib/systemd/system
    - require_in:
      - service: supervisor-service

supervisor-start-script-sysvinit:
  file.managed:
    - name: /etc/init.d/supervisor
    - source: salt://supervisor/files/supervisor.sysvinit
    - onlyif:
      - test -d /etc/init.d
    - require_in:
      - service: supervisor-service

supervisor-start-script-upstart:
  file.managed:
    - name: /etc/init/supervisor.conf
    - source: salt://supervisor/files/supervisor.upstart
    - onlyif:
      - test -d /etc/init
    - require_in:
      - service: supervisor-service

supervisor-service:
  service:
    - running
    - name: {{ supervisor.service }}
    - enable: True
    - require:
      - file: supervisor-config

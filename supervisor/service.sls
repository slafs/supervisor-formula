{% from "supervisor/map.jinja" import supervisor, supervisor_config with context %}

include:
  - supervisor
  - supervisor.conf

supervisor-start-script-systemd:
  file.managed:
    - name: /usr/lib/systemd/system/supervisor.service
    - source: salt://supervisor/templates/supervisor.systemd
    - template: jinja
    - context:
      config: {{ supervisor }}
    - onlyif:
      - test -d /usr/lib/systemd/system
    - require_in:
      - service: supervisor-service
    - require:
      - pip: supervisor

supervisor-start-script-sysvinit:
  file.managed:
    - name: /etc/init.d/supervisor
    - source: salt://supervisor/templates/supervisor.sysvinit
    - template: jinja
    - mode: 755
    - context:
      config: {{ supervisor }}
    - onlyif:
      - test -d /etc/init.d
    - require_in:
      - service: supervisor-service
    - require:
      - pip: supervisor

supervisor-start-script-upstart:
  file.managed:
    - name: /etc/init/supervisor.conf
    - source: salt://supervisor/templates/supervisor.upstart
    - template: jinja
    - context:
      config: {{ supervisor }}
    - onlyif:
      - test -d /etc/init
    - require_in:
      - service: supervisor-service
    - require:
      - pip: supervisor

supervisor-service:
  service:
    - running
    - name: {{ supervisor.service }}
    - enable: True
    - require:
      - file: supervisor-config

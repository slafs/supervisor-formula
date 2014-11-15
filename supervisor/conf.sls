{% from "supervisor/map.jinja" import supervisor, supervisor_config with context %}

include:
  - supervisor

supervisor-config:
  file.managed:
    - name: {{ supervisor.conf_file }}
    - source: salt://supervisor/templates/conf.jinja
    - template: jinja
    - context:
      config: {{ supervisor_config }}
    - watch_in:
      - service: supervisor
    - require:
      - pkg: supervisor

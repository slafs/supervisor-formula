{% from "supervisor/map.jinja" import supervisor with context %}

supervisor:
  pip:
    - installed
    - name: {{ supervisor.pkg }}

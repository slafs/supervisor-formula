==========
supervisor
==========

SaltStack formula for installing and configuring supervisor

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.


Available states
================

.. contents::
    :local:

``supervisor``
--------------

installs a supervisor package via pip

``supervisor.conf``
-------------------

ensures all the necessary directories are present and generates a main config file

``supervisor.service``
----------------------

ensures that all scripts are available also runs and enables the service

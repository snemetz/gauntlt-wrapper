gauntlt_wrapper
===========
Making running gauntlt in a CI workflow easier

The goal of this is to make it easy to run gauntlt 100% automated. Which means install scripts for all tools used, working templates that can be used without modifications.

## Table of Contents

* [Usage](#usage)
* [Documention](#documentation)
** [Targets File](#targets_file)
** [Template Files](#template_files)

## Usage

* Copy the contents of this repository to a directory
* `install-tools.sh` is a work in progress for installing all the tools in virtual environments on CentOS
* `init.env.sh` is for getting environment setup in a new shell after everything haas been installed
* `run.sh` is for generating the attack files and running gauntlt

* Create `gauntlt_gen.targets` using `gauntlt_gen.targets.example` as an example.
* Create/modify templates in `templates/` Keep the filenames simple, as they are referenced by the `gauntlt_gen.targets` file.

* Your attack files will be created in `attacks/` as `_gen_*.attack`
* Previously generated attack files will be deleted upon generation.

Please note that the templates included here are works in progress. Some are complete and some may need to be modified. Feel free to sumbit pull requests to add more templates.

## Documention

### Targets File

`gauntlt_gen.targets` file describes what should be run and what data is passed to the templates. It has 2 sections: `:data` and `attacks`

`:data` is where all data to be passed to the templates is defined. Any data item defined here will be passed to the template. But the templates defines what data items it uses

`:attacks` is a list of the attacks to run. The names match the file names of the templates

### Template Files

Template files reside under the `templates/` directory. Each one defines a specific attack and the results it should test for. These are Ruby ERB templates, so they will contain some Ruby code.

Using `nmap_os_apache.erb' as an example:
```
@announce-cmd
@slow

Feature: Service detection. Make sure Apache is running and does not display the version

  Background:
    Given "nmap" is installed
    And the following profile:
      | name     | value            |
      <% config.each do |name, value| -%>
      | <%= name %> | <%= value %> |
      <% end -%>

  Scenario: Detect OS
    When I launch an "nmap" attack with:
      """
      nmap -sV -p T:<port_open> -PN <hostname>
      """
    # Verify Apache server with no version info
    Then the output should contain:
      """
      Apache
      """
    But the output should not match:
      """
      Apache httpd [0-9.]+
      """
```
This start with 2 options: `@announce-cmd` to display the command line used and `@slow` to increase the timeout.


Thanks
======
- Patrick Morgan for gauntlt_gen. Which helped getting this started. My version is part of this repo and is not compatible with the original.
- Everyone working on gauntlt

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

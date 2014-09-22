gauntlt_wrapper
===========
Making running gauntlt in a CI workflow easier

The goal of this is to make it easy to run gauntlt 100% automated. Which means install scripts for all tools used, working templates that can be used without modifications.

Usage
===========

* Copy the contents of this repository to a directory
* `install-tools.sh` is a work in progress for installing all the tools in virtual environments on CentOS
* `init.env.sh` is for getting environment setup in a new shell after everything haas been installed
* `run.sh` is for generating the attack files and running gauntlt

* Create `gauntlt_gen.targets` using `gauntlt_gen.targets.example` as an example.
* Create/modify templates in `templates/` Keep the filenames simple, as they are referenced by the `gauntlt_gen.targets` file.

* Your attack files will be created in `attacks/` as `_gen_*.attack`
* Previously generated attack files will be deleted upon generation.

Please note that the templates included here are works in progress. Some are complete and some may need to be modified. Feel free to sumbit pull requests to add more templates.


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

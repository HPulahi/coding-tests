C******* Thinking Developer Test
==================================

Your test, should you decide to accept it, is to create a command line client
for the below API specification. Ruby is the preferred language, but you may
use any language you like i.e. php, python, java or .net.

You are not required to develop the API itself. An example API is provided for
you as a Ruby Sinatra application. This does require ruby to be installed on
your system:

Windows: http://rubyinstaller.org/
Other OS: http://www.ruby-lang.org/en/downloads/

Once you have a solution, please submit it by emailing a zip or compressed 
tar file to mailto:dev@concurrent-thinking.com. 

Many thanks
Concurrent Thinking Dev Team


JSON web service for developing submissions against
===================================================

We have developed a JSON based web application conforming to the specification
given in specification.md. It can be used to test your work against prior to
submission.

Installation / Running
----------------------

To run this web service, first install ruby and rubygems through your OS
package manager, or similar. Then run:

    cd "the specification directory - where the Gemfile is"
    gem install bundler
    bundle install

The web service can be run from the directory where it is unpacked. To start
the server run:

    bundle exec rackup


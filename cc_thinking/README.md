Herjit Pulahi Submission
==================================

Thankyou for allowing me to complete your test. I had fun in doing so!
I have left developer notes below.

Many thanks
Herj Pulahi

Installation / Running
----------------------

To run this client, first install ruby and rubygems through your OS
package manager, or similar. Then run:

    cd "the specification directory - where the Gemfile is"
    gem install bundler
    bundle install

The client api can be run from the directory where it is unpacked. To start
run:

  ruby init.rb --url "http://localhost:4567/metrics/machine_1"

Notes
-----

I have used some rubygems to help with the development of this application.

-- Clamp - This parses the command line client
-- RSpec - My Test suite of choice
-- Fuubar - RSpec color coding
-- Typhoeus - Helps to make simultaneous GET requests
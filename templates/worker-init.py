# -*- coding: utf-8 -*-
# Copyright © 2014 SEE AUTHORS FILE
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""
{{Worker_Name}} worker.
"""

import xmlrpclib

from reworker.worker import Worker


class {{Worker_Name}}WorkerError(Exception):
    """
    Base exception class for {{Worker_Name}}Worker errors.
    """
    pass


class {{Worker_Name}}Worker(Worker):
    """
    {{worker_short_description}}
    """

    subcommands = ['List', 'Of', 'Subcommands']
    # dynamic = []

    def verify_subcommand(self, parameters):
        """Verify we were supplied with a valid subcommand"""
        subcmd = parameters.get('subcommand', None)
        if subcmd not in self.subcommands:
            raise {{Worker_Name}}WorkerError("Invalid subcommand provided: %s" % subcmd)
        else:
            return True

    def process(self, channel, basic_deliver, properties, body, output):
        """Processes Sat5 requests from the bus.
        """
        # Ack the original message
        self.ack(basic_deliver)
        corr_id = str(properties.correlation_id)

        self.app_logger.info("Starting now")
        # Tell the FSM that we're starting now
        self.send(
            properties.reply_to,
            corr_id,
            {'status': 'started'},
            exchange=''
        )

        self.notify(
            "Subject",
            "Message",
            'started',
            corr_id
        )
        output.info("Starting now")

        try:
            self.verify_subcommand(body['parameters'])

            """Replace this comment block with your workers main logic.

            Try to keep blocks of related code in methods

            Inside each method you should raise
            {{Worker_Name}}WorkerError if there is a non-recoverable
            error. See "verify_subcommand" for an example.
            """

            # Everything following this means we were successful
            self.app_logger.info("Did the needful")
            self.send(
                properties.reply_to,
                corr_id,
                {'status': 'completed'},
                exchange=''
            )
            # Notify over various other comm channels about the result
            self.notify(
                'Subject',
                'Message',
                'completed',
                corr_id)

            # Output to the general logger (taboot tailer perhaps)
            output.info('Finishing message')

        except {{Worker_Name}}WorkerError, e:
            # If an error happens send a failure and log it to stdout
            self.app_logger.error('Failure: %s' % e)
            # Send a message to the FSM indicating a failure event took place
            self.send(
                properties.reply_to,
                corr_id,
                {'status': 'failed'},
                exchange=''
            )
            # Notify over various other comm channels about the event
            self.notify(
                '{{Worker_Name}} Worker Failed',
                str(e),
                'failed',
                corr_id)
            # Output to the general logger (taboot tailer perhaps)
            output.error(str(e))


def main():  # pragma: no cover
    from reworker.worker import runner
    runner({{Worker_Name}}Worker)


if __name__ == '__main__':  # pragma nocover
    main()

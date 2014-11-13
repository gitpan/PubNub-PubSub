use Test::More tests => 6;
use PubNub::PubSub::Message;

my @messages = 
  map { PubNub::PubSub::Message->new($_) }
        {
            message => 'test1',
            ortt => {
                "r" => 13,
                "t" => "13978641831137500"
            },
            meta => {
                "stuff" => []
            },
            ear  => 'True',
            seqn => 12345,
        },
        {
            message => 'test2',
            ortt => {
                "r" => 13,
                "t" => "13978641831137501"
            },
            meta => {
                "stuff" => []
            },
            ear  => 'True',
            seqn => 12346,
        },
        {
            message => { foo => 'test2', bar => 'test1'},
            ortt => {
                "r" => 13,
                "t" => "13978641831137501"
            },
            meta => {
                "stuff" => []
            },
            ear  => 'True',
            seqn => 12346,
        };

my @expected = ( 'test1', 'test2', { foo => 'test2', bar => 'test1'});
is_deeply($messages[$_]->payload, $expected[$_], 'got correct data, payload')
  for 0 .. (scalar @messages) - 1;

@expected = ( qr/"test1"/, qr/"test2"/, qr/"foo":"test2"/);
like($messages[$_]->json, $expected[$_], 'got correct data, payload')
  for 0 .. (scalar @messages) - 1;

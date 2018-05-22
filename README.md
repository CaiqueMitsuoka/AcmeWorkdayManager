# AcmeWorkdayManager

The parser for the [hehehe](https://www.youtube.com/watch?v=Lrj2Hq7xqQ8) coding interview. The goal is to parse a configuration json and a data json to generate a work hour report of employee on ACME company.

## Considerations

First let me address the elephant in the room: I'm not an professional Elixir developer, but a Ruby one. I want to start working with Elixir and this is the result of my off time studies. I can see a lot of improvement to my code, like the `AcmeWorkdayManager.Service.Entries` module which can be vastly improved to perform and be more readable. Anyway I'm new into Elixir and functional programming.

Although I have to point that I am pretty proud of what I achieved. I started this with no clear idea of architecture, how to actually create tasks and proper handle the data flow. I used one or two `if`s and vastly relied on pattern match to accomplish my goals.

One thing thing that I learn is how simple is to write tests in functional programming, although, even when the test was easy to do, I would take too much time in the solution itself, so I started testing most of my code and end it up with a lot of code not tested. This is a trade off that I took when I decided to go with Elixir, more development time. I worked in consultancy most of my carrer so I believe deeply in tests and the benefits of a good test suite and I dont think I expressed that is the test, sadly :(

## Run


Place the `config.json` and `timeclock_entries.json` in the root of the projects folder and run:

```shell
$ mix deps.get
$ mix resport
```

### Custom files

You can use other files names and paths.

```shell
# You can use both of either one.
$ mix report -c config.json -d timeclock_entries.json
```

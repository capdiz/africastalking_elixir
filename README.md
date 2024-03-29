# AfricastalkingElixir

**TODO: Add voice, bulk sms and mobile payments functionality**

##
Unofficial AfricasTalking elixir library that currently lets you send SMS through AfricasTalking messaging api.


## Installation

You can install this package by adding `africastalking_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:africastalking_elixir, "~> 0.1.0"}
  ]
end
```
You could have a look at it here https://hexdocs.pm/africastalking_elixir/0.1.0

## Usage
In order to send an SMS, we require a list of options like:

 `options = [username: "sandbox", to: "+256772******", message: "Omar's coming yo!"]`. 

If you are using your AfricasTalking sandbox account your username should be `sandbox`.

__Sending an SMS__

`AfricastalkingElixir.Sms.send_sms(options, apiKey, environment)`. 

If your app is in production, you should call the `send_sms/3` function as follows:

```
options = [username: "YOUR_AFRICAS_TALKING_APP_USERNAME", to: "+256772******", message: "Omar's comin yo!"]
api_key = "YOUR_AFRICASTALKING_API_KEY"
env = "production"

AfricastalkingElixir.Sms.send_sms(options, api_key, env)
```

If in development, you should call the `send_sms/3` function like:

```
options = [username: "sandbox", to: "+256772******", message: "Omar's comin yo!"]
api_key = "YOUR_AFRICASTALKING_API_KEY"

AfricastalkingElixir.Sms.send_sms(options, api_key, nil)
```

## LICENCE

This package is open source under the terms of the [MIT LICENCE](https://opensource.org/licenses/MIT)



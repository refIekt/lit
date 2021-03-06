# Lit CLI

<p align="center">
  <a href="https://www.mozilla.org/MPL/2.0/" alt="MPLv2 License">
    <img src="https://img.shields.io/badge/license-MPLv2-blue.svg" />
  </a>
  <a href="https://rubygems.org/gems/lit-cli">
    <img src="https://badge.fury.io/rb/lit-cli.svg" alt="Gem Version" />
  </a>
  <img src="https://img.shields.io/github/languages/code-size/refIekt/lit" alt="GitHub code size in bytes">
  <img src="https://img.shields.io/gem/dt/lit-cli">
</p>

*Shine a light on terminal commands.* 🔥

Lit lets you create console logs that are only visible after prefixing a command with `lit`. You can use flags to filter the types of logs and step through your application at runtime, essentially turning your logs into breakpoints. You can press Enter to continue to the next step or press P to begin a [Pry](https://github.com/pry/pry) session. Lit was originally created to view the reflections generated by [Reflekt](https://reflekt.dev) via the command line, but can be used in a range of applications.

## Usage

Simply start any command with `lit`. For example a script like `ruby script.rb` becomes:
```
lit ruby script.rb
```

Then run the application and watch the terminal window for Lit messages:
<p align="center">
  <img src="/assets/images/lit.png" width="850"/>
</p>

### Flags

Lit accepts flags to modify behaviour. They are prefixed with an `@` and appended after the `lit` command:
```
lit @<flag-name> ruby <script-name>.rb
```

Flags start with an `@` instead of a `--` so that they aren't confused with flags for the original command that Lit is firing off.

#### @step

<img src="/assets/gifs/step.gif" width="750"/>

Step through the code. The terminal will stop at each `lit()` message, then prompt you to press *Enter* to continue to the next message or press *P* to enter a Pry session.
```
lit @step ruby script.rb
```

When in a Pry session, enter `x` to exit Pry or `!!!` to exit the program (use `x;` to access a variable called `x`).

**Note:** Only files required via `require_relative` are currently supported for Pry session.  
**Note:** Pry is not available to `lit()` messages in the *first* file to `require 'lit_cli'`, so require Lit in your application's entry point / main file if you need this feature.

#### @status

Filter logs by message status:
```
lit @status=error ruby script.rb
```

Multiple statuses are comma separated:
```
lit @status=fail,error ruby script.rb
```

#### @type

Filter logs by message type:
```
lit @type=cat,dog ruby script.rb
```

Types are optional and represent the type of data, similar to a class.

#### @delay

<img src="/assets/gifs/delay.gif" width="750"/>

Delay the execution of a message to make fast outputting logs easier to read. The default delay is `0` seconds (no delay) but can be any positive `Integer` or `Float`, for example:
```
lit @delay=1 ruby script.rb
```

## Installation

In Gemfile add:
```ruby
gem 'lit-cli'
```  

In terminal run:
```
bundle install
```

Or:
```
gem install lit-cli
```

If an application is currently using Lit then the `lit` command will already be available in your terminal without any installation required.

## API

Instructions for integrating your application with Lit.

### Usage

Require `lit_cli` at the top of your file:
```ruby
require 'lit_cli'
```

Include `LitCLI` in your `module` or `class`:
```ruby
class ExampleClass
  include LitCLI
```

Then use the `lit()` instance method:
```ruby
lit "message"
```

### lit()

```ruby
lit(message, status = :info, type = nil, context = nil)
```

* String `message` - The message to show.
* Symbol `status` (optional) - The status of the message such as `:info`, `:warn` or `:error`.
* Symbol `type` (optional) - The type of data this message represents such as `:cat` or `:dog`.
* String `context` (optional) - The current class name or instance ID, anything that gives context.

Available statuses and types can be configured, see `lib/config.rb` and `demo/demo.rb` for more info.

### Symbols

Special characters convey extra meaning when embedded in the `message` string.

#### method()

```ruby
lit "message method()"
```

Placing `()` next to a word will style them as a method.

#### #number

```ruby
lit "message #1"
```

Placing a `#` next to a number will style them as a number.

#### >indent

```ruby
lit "> message"
```

Placing a `>` at the start of a message will indent the log in the console. Multiple `>>>` symbols can be used and for each one, two spaces of indentation will be added. Indentation is not preserved when using `@status` or `@type` filters.

#### ^separator

```ruby
lit "^ message"
```

Placing a `^` at the start of a message will add a line break above the log in the console. Multiple `^^^` symbols can be used and for each one, one line break will be added. Line breaks are not preserved when using `@status` or `@type` filters.

### Code as comments

You can use the `lit()` method in place of comments to help document your code. This:
```ruby
# Create control for method.
control = Control.new(action, 0, @@reflekt.aggregator)
action.control = control
```

Becomes this:
```ruby
lit "Create control for #{method} method"
control = Control.new(action, 0, @@reflekt.aggregator)
action.control = control
```

Now you've commented your code and your comments double as logs.

### Emoji support

You can even use the emoji `🔥()` instead of `lit()` to call the method... cause why not? Climate change is real and we're all going to die anyway. So the final code could be:

```ruby
🔥 "Create control for #{method} method"
control = Control.new(action, 0, @@reflekt.aggregator)
action.control = control
```

The lit emoji acts as a nice sectional heading too. These are all just ideas and it's up to you to decide how to write code and save the future of humanity.

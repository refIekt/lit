# Lit CLI

<p align="center">
  <a href="https://www.mozilla.org/MPL/2.0/" alt="MPLv2 License">
    <img src="https://img.shields.io/badge/license-MPLv2-blue.svg" />
  </a>
  <a href="https://rubygems.org/gems/lit-cli">
    <img src="https://badge.fury.io/rb/lit-cli.svg" alt="Gem Version" />
  </a>
</p>

*Shine a light on terminal commands.* 🔥

Lit lets you create console logs that are only visible after prefixing a command with `lit`. You can use flags to filter the types of logs and step through your application at runtime, essentially turning your logs into breakpoints. You can press Enter to continue to the next step or press P to begin a [Pry](https://github.com/pry/pry) session. Lit was originally created to view the metadata generated at runtime by [Reflekt](https://reflekt.dev).

## Usage

Simply start any command with `lit`. For example `rails server` becomes:
```
lit rails server
```

A script like `ruby script.rb` becomes:
```
lit ruby script.rb
```

Then run the application and watch the terminal window for Lit messages:
<pre class="code">
🔥 12:50 <span style="color:blue">ℹ info</span> Half price books at Jane's Book Emporium
🔥 12:50 <span style="color:green">✔ pass</span> Amazing news, we're getting married!
🔥 12:50 <span style="color:red">⨯ fail</span> They've run out of ice cream Timmy
</pre>

### Flags

Lit accepts flags to modify behaviour. They are prefixed with an `@` and appended after the `lit` command:
```
lit @<flag-name> ruby <script-name>.rb
```

Flags start with an `@` instead of a `--` so that they aren't confused with flags for the original command that Lit is firing off.

#### @step

Step through the code. The terminal will stop at each `lit()` message, then prompt you to press *Enter* to continue to the next message or press *P* to enter a Pry session.
```
lit @step ruby script.rb
```

**Note:** Only files required via `require_relative` are currently supported for Pry session.  
**Note:** Pry is not available to `lit()` messages in the *first* file to `require 'lit_cli'`, so require Lit in your application's entry point / main file if you need this feature.

#### @type

Filter logs by message type:
```
lit @type=error ruby script.rb
```

#### @delay

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

At the top of your file add:
```ruby
require 'lit_cli'
include LitCLI
```

Then use the `lit()` method:
```ruby
lit "message"
```

Display a warning message:
```ruby
lit "Danger, Will Robinson!", :warn
```
Message types can be configured, see `demo/demo.rb` for more info.

#### Code as comments

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

You can even use the emoji `🔥()` instead of `lit()` to call the method... cause why not? Climate change is real and we're all going to die anyway. So the final code could be:

```ruby
🔥 "Create control for #{method} method"
control = Control.new(action, 0, @@reflekt.aggregator)
action.control = control
```

The lit emoji acts as a nice sectional heading too. These are all just ideas and it's up to you to decide how to write code and save the future of humanity.

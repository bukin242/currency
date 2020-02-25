App.rate = App.cable.subscriptions.create "RateChannel",
  connected: ->
    console.log 'Connected!' if window._rails_env.is_development()

  received: (data) ->
    console.log data.value if window._rails_env.is_development()
    $("[data-channel='rate']").html data.value

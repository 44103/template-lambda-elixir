defmodule Trial do

  def handle(event, context) do
    :erllambda.message("event: ~p", [event])
    :erllambda.message("context: ~p", [context])

    post_to_slack(event["body"])

    {:ok, response({:ok, [[{"response", "OK"}]]})}
  end

  defp items_to_json(items) do
    items
    |> Enum.map(&:maps.from_list/1)
    |> :jiffy.encode
  end

  defp response({:ok, response}) do
    %{
      statusCode: "200",
      body: items_to_json(response),
      headers: %{
        "Content-Type": "application/json"
      }
    }
  end

  defp response({:error, response}) do
    %{
      statusCode: "400",
      body: response,
      headers: %{
        "Content-Type": "application/json"
      }
    }
  end

  def post_to_slack(body) do
    url = "https://slack.com/api/chat.postMessage"
    token = System.get_env("SLACK_TOKEN")

    payload = %{
      "token": token,
      "channel": "#documents",
      "text": Jason.decode!(body)["text"]
    }

    headers = [
      {"Content-type", "application/json"},
      {"Authorization", "Bearer #{token}"}
    ]

    response = HTTPoison.post!(url, Jason.encode!(payload), headers, [])

    # Logger.info "response: #{inspect response}"
  end
end

defmodule DiscordEmbedValidator do
  alias Skooma.Validators
  alias DiscordEmbedValidator.Utils


  @moduledoc """
  Documentation for `DiscordEmbedValidator`.
  """

  @doc """
  Valid an Embed

  ## Examples

      iex> DiscordEmbedValidator.valid?(%{description: "my embed description", title: "my embed title"})
      :ok
  """

  def valid?(embed) do
    cond do
      is_struct(embed) ->
        embed
        |> Map.from_struct
        |> valid?
      is_map(embed) ->
        validate(embed)
    end
  end

  defp validate(embed) do
    validate(embed, [:body, :footer], :ok)
  end

  defp validate(embed, [head | tail], :ok) do
    result = handle_validate_field(head, embed)
    validate(embed, tail, result)
  end

  defp validate(_embed, [], result), do: result

  defp validate(_embed, _check, {:error, reason}) do
    {:error, reason}
  end

  defp handle_validate_field(:body, embed) do
    schema = %{
      title: [:string, :not_required, Validators.max_length(256)],
      description: [:string, :not_required, Validators.max_length(2048)],
      url: [:string, :not_required, &Utils.is_url/1],
      timestamp: [:string, :not_required, &Utils.is_iso8601/1],
      color: [:number, :not_required, &Utils.is_color/1],
    }

    Skooma.valid?(embed, schema)
  end

  defp handle_validate_field(:footer, embed) do
    case Map.get(embed, :footer) do
      nil -> :ok
      footer ->
        url_schema = [:string, :not_required, &Utils.is_url/1]

        footer_schema = %{
          text: :string,
          icon_url: url_schema,
          proxy_icon_url: url_schema
        }

        Skooma.valid?(footer, footer_schema)
    end
  end
end

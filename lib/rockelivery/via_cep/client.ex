defmodule Rockelivery.ViaCep.Client do
  use Tesla

  alias Rockelivery.{Error, ViaCep.Behaviour}

  @behaviour Behaviour

  @base_url "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  def get_cep_info(url \\ @base_url, cep) do
    "#{url}#{cep}/json/"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}) do
    build_error(:not_found, "CEP not found!")
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Tesla.Env{status: 400, body: _body}}) do
    build_error(:bad_request, "Invalid CEP!")
  end

  defp handle_get({:error, reason}) do
    build_error(:bad_request, reason)
  end

  defp build_error(status, result), do: {:error, Error.build(status, result)}
end

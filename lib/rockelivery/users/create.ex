defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}

  def call(%{"cep" => cep} = params) do
    with {:ok, %User{} = _user} <- User.build(params),
         {:ok, _cep_info} <- client().get_cep_info(cep),
         {:ok, %User{}} = user <- create_user(params) do
      user
    else
      {:error, %Error{}} = error ->
        error

      {:error, result} ->
        {:error, Error.build(:bad_request, result)}
    end
  end

  defp client do
    :rockelivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end

  defp create_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end

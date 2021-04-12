defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, Repo, User}

  def call(%{"id" => uuid} = params) do
    case Repo.get(User, uuid) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> update_user(user, params)
    end
  end

  defp update_user(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end

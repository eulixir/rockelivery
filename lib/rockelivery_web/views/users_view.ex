defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created successfully",
      token: token,
      user: user
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end

  def render("user.json", %{user: %User{} = user}), do: %{user: user}
end

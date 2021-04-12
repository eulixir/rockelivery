defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", token: "xpto1234", user: user)

    assert %{
             message: "User created successfully",
             token: "xpto1234",
             user: %User{
               address: "Rua das banananeiras 15",
               age: 27,
               cep: "12345678",
               cpf: "12345678901",
               email: "rafael@banana.com",
               id: "e0cb8256-1eb5-4cc5-8549-4a61671b3d18",
               inserted_at: nil,
               name: "Rafael Camarda",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               address: "Rua das banananeiras 15",
               age: 27,
               cep: "12345678",
               cpf: "12345678901",
               email: "rafael@banana.com",
               id: "e0cb8256-1eb5-4cc5-8549-4a61671b3d18",
               inserted_at: nil,
               name: "Rafael Camarda",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end

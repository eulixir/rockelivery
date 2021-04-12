defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create
  alias Rockelivery.ViaCep.ClientMock

  import Mox
  import Rockelivery.Factory

  describe "call/1" do
    setup :verify_on_exit!

    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 27, cpf: "12345678901", email: "rafael@banana.com"}} =
               response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:user_params, %{
          "cep" => "1234567",
          "cpf" => "123456789",
          "password" => "12345"
        })

      response = Create.call(params)
      {:error, %Error{result: changeset}} = response

      expected_errors = %{
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request}} = response
      assert errors_on(changeset) == expected_errors
    end
  end
end

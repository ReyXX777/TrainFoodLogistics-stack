defmodule TrainFoodDelivery.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :is_volunteer, :boolean, default: false
    field :volunteer_verified, :boolean, default: nil  # Volunteer verification initially set to nil
    field :phone_number, :string                       # New field for phone number
    field :role, :string, default: "user"              # New field for role (e.g., "user", "admin")
    field :profile_completed, :boolean, default: false # New field to track profile completion status
    
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :is_volunteer, :volunteer_verified, :phone_number, :role, :profile_completed])
    |> validate_required([:email, :username, :password])
    |> validate_format(:email, ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, message: "invalid email format")
    |> validate_length(:username, min: 3, max: 20, message: "username must be between 3 and 20 characters")
    |> validate_length(:password, min: 6, message: "password must be at least 6 characters long")
    |> validate_format(:phone_number, ~r/^\+?[1-9]\d{1,14}$/, message: "invalid phone number format") # Validate phone number
    |> validate_inclusion(:role, ["user", "admin"], message: "role must be either 'user' or 'admin'") # Validate role
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> unique_constraint(:phone_number)
    |> put_password_hash()
  end

  # Hash the password before storing it in the database
  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, hashpwsalt(password))
    end
  end
end

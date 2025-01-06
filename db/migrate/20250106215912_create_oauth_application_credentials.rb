class CreateOauthApplicationCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :oauth_application_credentials do |t|
      t.references :application, null: false, foreign_key: true
      t.string :client_id, null: false, index: { unique: true }
      t.string :client_secret, null: false, index: { unique: true }
      t.datetime :revoked_at

      t.timestamps
    end
  end
end

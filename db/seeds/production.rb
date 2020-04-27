User.create!(name: "First User", 
  email: "first@example.com",
  password: "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now)
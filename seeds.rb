require './main'

User.create(name: 'learn', user_type: :source)
User.create(name: 'github', user_type: :source)
master = User.create(name: 'alexwang', user_type: :user)

Token.create(user_id: master.id, token_string: '123')
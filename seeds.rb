require './main'
require 'digest'

p = Digest::MD5.hexdigest('123')
User.create(name: 'learn', user_type: :source, password_md5: p)
User.create(name: 'github', user_type: :source, password_md5: p)
User.create(name: 'vultr', user_type: :source, password_md5: p)
master = User.create(name: 'alexwang', user_type: :user, password_md5: p)

Token.create(user_id: master.id, token_string: '123')

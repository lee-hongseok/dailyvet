# encoding:utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.new

u.name = "홍길동"
u.user_id = "a"
u.nickname = "홍길동별명"
u.password =Digest::SHA512.hexdigest("a") 
u.email = "jang2poom@naver.com"
u.phone_number = "01090090463"
u.city = "서울시"
u.county = "관악구"
u.address_detail = "자세한주소"
u.field = 1
u.vet_number = "00000000"
u.token = "abcdefg"
u.save

1.upto(30) do |x|
p = Post.new
p.user_id = 1
p.title = "테스트#{x} ~테스트#{x} ~테스트#{x} ~"
p.content = "테스트입니다 테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다"
p.category = 1
p.save
end



ja = %w[기타 일반업체 공무원 산업동물임상 반려동물임상]
ja.each do |x|
j = JobPost.new
j.user_id = 1
j.each = "each"
j.hour = "hour"
j.name = "name"
j.address_detail = "address_detail"
j.to = "to"
j.pay = "pay"
j.qualification = "qulification"
j.experience = "experience"
j.favorite = "f"
j.tel = "tel"
j.hp = "hp"
j.method= "m"
j.dead_line = "d"
j.detail = "d"
j.title = "테스트 테스트 테스트 "
j.category = x
j.city = "서울"
j.county = "관악구"
j.save
end


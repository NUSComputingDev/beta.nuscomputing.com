# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# { role: member }
{ 
	acad: "acad", 
  ar: "alumnirelations",
  finance: "finance",
  fop: "fop",
  it: "infotech",
  log: "logistics",
  marketing: "marketing",
  pcell: ["pcell", "president", "vp.extrel", "vp.hrd", "vp.ops", "secretariat"],
  publicity: "pub",
  sports: "sports",
  welfare: "welfare"
}.each do |role, members|
	rol = Role.create(name: role)
	if members.respond_to? :each
		members.each do |mem|
			email = "#{mem}@nuscomputing.com"
			rol.members.create(email: email)
		end
	else
		email = "#{members}@nuscomputing.com"
		rol.members.create(email: email)
	end
end

# Locker
# [A, B, C, D, E, F, G, H]
# [0, 1, 2, 3, 4, 5, 6, 7]
{ 
	0 => ["3137-3168", "3173-3208", "3529-3532"],
	1 => ["3065-3136", "3473-3504", "3413-3472", "3372-3412"],
	2 => ["3209-3280"],
	3 => ["3513-3520", "3353-3372"],
	4 => ["2069-2136", "2137-2200", "3281-3340", "3349-3352"],
	5 => ["2205-2272"],
	6 => ["2001-2068"],
	7 => ["3533-3544", "3169-3172", "2505-2512", "3521-3528"]
}.each do |loc, number_ranges|
	number_ranges.each do |range|
		range_num = range.split('-').map { |x| x.to_i } #range_num[0] is the starting number and range_num[1] is ending
		(range_num[0]..range_num[1]).each do |num|
			Locker.create location: loc, number: num.to_s, status: 0 #status: 0 - vacant, 1 - occupied
		end
	end
end


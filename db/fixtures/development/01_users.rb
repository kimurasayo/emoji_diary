User.seed(
  :id,
  { id: 1, nickname: 'sayo', name: 'kimsayo', crypted_password: User.encrypt('password') },
  { id: 2, nickname: 'eri', name: 'eri1112', crypted_password: User.encrypt('password') },
  { id: 3, nickname: 'yuka', name: 'yuka911', crypted_password: User.encrypt('password') },
  { id: 4, nickname: 'miki', name: 'mickey', crypted_password: User.encrypt('password') },
  { id: 5, nickname: 'yuki', name: 'yuki8', crypted_password: User.encrypt('password') },
  { id: 6, nickname: 'ayaka', name: 'ayaka110', crypted_password: User.encrypt('password') },
  { id: 7, nickname: 'asa', name: 'asako', crypted_password: User.encrypt('password') },
  { id: 8, nickname: 'mari', name: 'mari7', crypted_password: User.encrypt('password') },
  { id: 9, nickname: 'yuna', name: 'yuna61', crypted_password: User.encrypt('password') },
  { id: 10, nickname: 'hina', name: 'hina4', crypted_password: User.encrypt('password') },
)

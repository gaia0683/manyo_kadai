FactoryBot.define do
  factory :user do
    name {'kimu'}
    email {'kimu@kimu.com'}
    password {'gaia0683'}
    password_confirmation {'gaia0683'}
  end
  factory :second_user, class: User do
    name {'bomu'}
    email {'bomu@bomu.com'}
    password {'gaia0683'}
    password_confirmation {'gaia0683'}
  end
  factory :third_user, class: User do
    name {'kimubomute'}
    email {'kimubomute@kimubomute.com'}
    password {'gaia0683'}
    password_confirmation {'gaia0683'}
    admin_user {'true'}
  end
end

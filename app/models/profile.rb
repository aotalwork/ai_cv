class Profile < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :achievements, dependent: :destroy
  has_many :recommendations, dependent: :destroy
end
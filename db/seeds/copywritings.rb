User.all.each do |user|
  if user.plugins.where(:name => 'refinerycms_copywriting').blank?
    user.plugins.create(:name => 'refinerycms_copywriting',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

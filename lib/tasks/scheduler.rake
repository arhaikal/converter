desc "This task updates api once per day"

task update_api: :environment do
  FixerApi.add_api_to_db(Date.today) if Date.today.on_weekday?
end

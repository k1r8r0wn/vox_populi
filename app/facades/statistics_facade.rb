class StatisticsFacade

  def registered_users
    User.group_by_day(:created_at).count
  end

  def problems_in_categories
    problems = []
    categories = Category.eager_load(:themes)

    categories.each do |category|
      problems << [ category.name, category.themes.size ]
    end

    problems
  end

  def top_voted_problems
    problems = []
    themes = Theme.tally.limit(5).where('vote > ?', false)

    themes.each do |problem|
      problems << [ problem.title, problem.votes_for ]
    end

    problems
  end
end

# Clear existing achievements
Achievement.delete_all

# Categories for achievements
categories = [
  'Project Completion',
  'Leadership',
  'Innovation',
  'Team Collaboration',
  'Learning & Development',
  'Problem Solving',
  'Recognition',
  'Other'
]

# Realistic achievement titles and descriptions
achievement_templates = [
  {
    title: "Completed Q{quarter} sprint ahead of schedule",
    description: "Successfully delivered all planned features for the quarterly sprint 2 weeks ahead of the original deadline. Collaborated closely with the design team to ensure pixel-perfect implementation while maintaining high code quality standards.",
    categories: ['Project Completion', 'Team Collaboration']
  },
  {
    title: "Led migration to {technology} framework",
    description: "Spearheaded the technical migration from legacy system to modern {technology} architecture. Reduced build times by 40% and improved developer experience. Mentored 3 junior developers throughout the process.",
    categories: ['Leadership', 'Innovation']
  },
  {
    title: "Reduced API response time by {percentage}%",
    description: "Identified and optimized database queries that were causing performance bottlenecks. Implemented caching strategy and database indexing improvements, resulting in significantly faster API responses and improved user experience.",
    categories: ['Innovation', 'Problem Solving']
  },
  {
    title: "Mentored {number} new team members",
    description: "Provided comprehensive onboarding and ongoing mentorship to new developers joining the team. Created documentation and training materials that are now used company-wide for new hire orientation.",
    categories: ['Leadership', 'Team Collaboration']
  },
  {
    title: "Earned {certification} certification",
    description: "Completed comprehensive training program and successfully passed the certification exam. Applied new knowledge to improve current projects and shared learnings with the team through brown bag sessions.",
    categories: ['Learning & Development']
  },
  {
    title: "Implemented automated testing suite",
    description: "Designed and built comprehensive automated testing framework that increased code coverage from 45% to 85%. Reduced manual testing time by 60% and significantly decreased production bugs.",
    categories: ['Innovation', 'Problem Solving']
  },
  {
    title: "Resolved critical production incident",
    description: "Quickly diagnosed and fixed a critical system outage that was affecting customer transactions. Coordinated with multiple teams to implement a solution within 2 hours, minimizing business impact.",
    categories: ['Problem Solving', 'Leadership']
  },
  {
    title: "Presented at {conference} conference",
    description: "Delivered a well-received presentation about our team's innovative approach to scalable architecture. Generated positive feedback from industry peers and potential recruiting leads.",
    categories: ['Recognition', 'Learning & Development']
  },
  {
    title: "Launched {feature} feature successfully",
    description: "Led the end-to-end development and launch of a major new product feature. Collaborated with product managers, designers, and QA to ensure successful delivery that exceeded user engagement targets by 25%.",
    categories: ['Project Completion', 'Team Collaboration']
  },
  {
    title: "Established code review best practices",
    description: "Created and implemented standardized code review guidelines that improved code quality and knowledge sharing across the development team. Reduced average PR review time by 30%.",
    categories: ['Leadership', 'Team Collaboration']
  },
  {
    title: "Won {award} award for innovation",
    description: "Received company-wide recognition for developing an innovative solution that streamlined internal processes. The solution is now being adopted by other teams and has saved an estimated 20 hours per week.",
    categories: ['Recognition', 'Innovation']
  },
  {
    title: "Organized successful team hackathon",
    description: "Planned and executed a 2-day team hackathon that resulted in 3 prototype features, improved team bonding, and generated several ideas that are now being considered for the product roadmap.",
    categories: ['Leadership', 'Team Collaboration']
  },
  {
    title: "Reduced deployment time by {percentage}%",
    description: "Optimized CI/CD pipeline and containerization strategy, dramatically reducing deployment time and increasing deployment reliability. Zero-downtime deployments are now the standard.",
    categories: ['Innovation', 'Problem Solving']
  },
  {
    title: "Completed advanced {skill} course",
    description: "Invested personal time to complete an intensive course in {skill}. Immediately applied new skills to current projects, resulting in more efficient code and better architectural decisions.",
    categories: ['Learning & Development']
  },
  {
    title: "Collaborated on cross-team integration",
    description: "Successfully worked with the mobile team to design and implement API endpoints that support both web and mobile applications. Ensured consistent data structures and optimal performance for all platforms.",
    categories: ['Team Collaboration', 'Project Completion']
  }
]

# Technology options for placeholders
technologies = ['React', 'Vue.js', 'Angular', 'Node.js', 'Python', 'Kubernetes', 'Docker', 'GraphQL', 'TypeScript', 'PostgreSQL']
percentages = [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80]
numbers = (2..8).to_a
quarters = ['Q1', 'Q2', 'Q3', 'Q4']
certifications = ['AWS Solutions Architect', 'Google Cloud Professional', 'Certified Scrum Master', 'PMP', 'Kubernetes Administrator']
conferences = ['DevConf', 'ReactConf', 'RubyConf', 'KubeCon', 'DockerCon', 'AWSome Day']
features = ['user dashboard', 'payment system', 'notification center', 'search functionality', 'analytics dashboard', 'mobile app']
awards = ['Innovation Excellence', 'Employee of the Month', 'Technical Excellence', 'Team Player', 'Problem Solver']
skills = ['machine learning', 'data science', 'cloud architecture', 'security', 'UI/UX design', 'project management']

puts "Creating 500 realistic achievement entries..."

500.times do |i|
  # Select a random template
  template = achievement_templates.sample
  
  # Replace placeholders in title and description
  title = template[:title].dup
  description = template[:description].dup
  
  title.gsub!('{technology}', technologies.sample)
  title.gsub!('{percentage}', percentages.sample.to_s)
  title.gsub!('{number}', numbers.sample.to_s)
  title.gsub!('{quarter}', quarters.sample)
  title.gsub!('{certification}', certifications.sample)
  title.gsub!('{conference}', conferences.sample)
  title.gsub!('{feature}', features.sample)
  title.gsub!('{award}', awards.sample)
  title.gsub!('{skill}', skills.sample)
  
  description.gsub!('{technology}', technologies.sample)
  description.gsub!('{percentage}', percentages.sample.to_s)
  description.gsub!('{number}', numbers.sample.to_s)
  description.gsub!('{quarter}', quarters.sample)
  description.gsub!('{certification}', certifications.sample)
  description.gsub!('{conference}', conferences.sample)
  description.gsub!('{feature}', features.sample)
  description.gsub!('{award}', awards.sample)
  description.gsub!('{skill}', skills.sample)
  
  # Generate a random date within the last 2 years
  date = Date.current - rand(730).days
  
  # Select a category from the template's suggested categories
  category = template[:categories].sample
  
  Achievement.create!(
    title: title,
    description: description,
    date: date,
    category: category
  )
  
  print "." if (i + 1) % 50 == 0
end

puts "\n✅ Successfully created #{Achievement.count} achievements!"
puts "Categories distribution:"
categories.each do |cat|
  count = Achievement.where(category: cat).count
  puts "  #{cat}: #{count} achievements"
end

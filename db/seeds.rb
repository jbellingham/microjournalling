# Clear existing achievements
Achievement.delete_all

# Find or create a default user for seeding
user = User.first || User.create!(
  name: "Demo User",
  email: "demo@example.com",
  password: "password123"
)

# New unified categories
categories = [
  'Projects',
  'Leadership & Innovation',
  'Collaboration & mentorship',
  'Design & documentation',
  'Problem Solving & Recognition',
  'Company building',
  'Learning & Development',
  'Outside of work'
]

# Realistic achievement templates with brag doc details
achievement_templates = [
  {
    title: "Led migration to {technology} framework",
    description: "Spearheaded the technical migration from legacy system to modern {technology} architecture, coordinating across 4 teams and managing technical risks.",
    category: 'Projects',
    impact_metrics: "Reduced build times by {percentage}%, improved developer productivity by 3x, eliminated 12 hours/week of manual deployment work, supporting 500+ daily deploys",
    collaboration_details: "Led cross-functional team of {number} engineers, mentored 2 junior developers through complex migration tasks, facilitated weekly stakeholder updates with product and infrastructure teams",
    learning_outcomes: "Gained expertise in {technology} architecture patterns, learned advanced CI/CD optimization techniques, developed skills in large-scale technical project management",
    goals_supported: "Directly supported Q{quarter} engineering velocity goals and platform modernization OKR, enabled team to meet aggressive product delivery timelines"
  },
  {
    title: "Mentored {number} new team members through onboarding",
    description: "Provided comprehensive technical mentorship and career guidance to new engineers, creating structured learning paths and fostering team integration.",
    category: 'Collaboration & mentorship',
    impact_metrics: "Reduced new hire time-to-productivity from 8 weeks to 4 weeks, achieved 100% retention rate for mentees, improved team code review quality scores by {percentage}%",
    collaboration_details: "Conducted weekly 1:1s, paired on complex features, created team knowledge sharing sessions, collaborated with hiring manager to improve onboarding process",
    learning_outcomes: "Developed leadership and coaching skills, learned to adapt communication style to different learning preferences, gained experience in technical curriculum design",
    goals_supported: "Contributed to team scaling goals and engineering culture OKRs, supported company's commitment to technical excellence and knowledge sharing"
  },
  {
    title: "Designed microservices architecture for {feature} system",
    description: "Architected and documented a scalable microservices solution for high-traffic feature, considering performance, maintainability, and team autonomy.",
    category: 'Design & documentation',
    impact_metrics: "System handles 10M+ daily requests with 99.9% uptime, reduced cross-team dependencies by {percentage}%, documentation viewed by {number}+ engineers",
    collaboration_details: "Led architecture review sessions with senior engineers, gathered requirements from 3 product teams, presented design to engineering leadership for approval",
    learning_outcomes: "Mastered distributed systems design patterns, learned advanced {technology} capabilities, developed skills in technical writing and stakeholder communication",
    goals_supported: "Enabled product team velocity goals by reducing system coupling, supported platform reliability OKRs through improved architecture"
  },
  {
    title: "Resolved critical production incident affecting {percentage}% of users",
    description: "Led incident response for major system outage, coordinated cross-team debugging effort, and implemented comprehensive fixes and preventive measures.",
    category: 'Problem Solving & Recognition',
    impact_metrics: "Restored service within 2 hours, prevented estimated ${amount}K in lost revenue, received CEO recognition for exceptional incident response",
    collaboration_details: "Coordinated with SRE, product, and customer success teams during incident, led post-mortem review with {number} stakeholders, mentored team on incident response best practices",
    learning_outcomes: "Gained advanced debugging skills under pressure, learned incident command protocols, developed crisis communication and leadership abilities",
    goals_supported: "Reinforced company's commitment to reliability and customer trust, demonstrated engineering team's capability to handle critical situations"
  },
  {
    title: "Established engineering interview process improvements",
    description: "Redesigned technical interview framework to reduce bias, improve candidate experience, and better assess real-world engineering skills.",
    category: 'Company building',
    impact_metrics: "Improved diverse candidate pass rate by {percentage}%, reduced interview-to-offer time by 5 days, increased candidate satisfaction scores to 4.8/5.0",
    collaboration_details: "Collaborated with recruiting team and engineering managers across 5 teams, trained {number} engineers on new interview techniques, gathered feedback from candidates and interviewers",
    learning_outcomes: "Learned about bias in technical hiring, developed skills in process design and change management, gained experience in training and documentation",
    goals_supported: "Advanced company diversity and inclusion goals, supported rapid team growth objectives while maintaining hiring quality standards"
  },
  {
    title: "Mastered {technology} and became team expert",
    description: "Deep-dived into {technology} ecosystem, became go-to person for complex problems, and established team best practices and standards.",
    category: 'Learning & Development',
    impact_metrics: "Answered {number}+ technical questions weekly, reduced team's {technology} debugging time by {percentage}%, gave 3 internal tech talks to 50+ engineers",
    collaboration_details: "Mentored teammates on {technology} concepts, led architecture discussions, created internal documentation and training materials",
    learning_outcomes: "Achieved expert-level proficiency in {technology}, developed teaching and knowledge transfer skills, learned to evaluate and adopt new technologies strategically",
    goals_supported: "Built team's technical capabilities to meet product roadmap requirements, supported professional development goals for entire engineering organization"
  },
  {
    title: "Presented at {conference} conference on scalable architecture",
    description: "Delivered technical presentation to industry audience about innovative architecture patterns, representing company as thought leader.",
    category: 'Outside of work',
    impact_metrics: "Reached audience of 500+ engineers, generated 15 recruitment leads, talk viewed 10K+ times online, featured in industry newsletter",
    collaboration_details: "Collaborated with marketing team on talk preparation, coordinated with conference organizers, networked with industry peers and potential candidates",
    learning_outcomes: "Developed public speaking and presentation skills, learned to distill complex technical concepts for diverse audiences, gained confidence in representing company externally",
    goals_supported: "Enhanced company's technical reputation and employer brand, supported recruitment efforts and thought leadership goals"
  },
  {
    title: "Launched {feature} feature exceeding success metrics",
    description: "Led full-stack development and launch of major product feature, coordinating across engineering, product, design, and data teams.",
    category: 'Projects',
    impact_metrics: "Feature achieved 25% higher user engagement than projected, generated $50K additional monthly revenue, reduced customer support tickets by {percentage}%",
    collaboration_details: "Worked closely with product manager and designer, coordinated testing with QA team, collaborated with data team on analytics implementation",
    learning_outcomes: "Gained experience in full product lifecycle, learned advanced {technology} techniques, developed product sense and user empathy skills",
    goals_supported: "Directly contributed to Q{quarter} revenue targets and user experience goals, demonstrated engineering's ability to deliver high-impact features"
  },
  {
    title: "Pioneered automated deployment pipeline reducing release risk",
    description: "Designed and implemented zero-downtime deployment system with automated rollback capabilities, transforming team's release confidence.",
    category: 'Leadership & Innovation',
    impact_metrics: "Reduced deployment failures by 90%, enabled daily releases instead of weekly, saved engineering team 15 hours/week of manual deployment work",
    collaboration_details: "Built consensus among {number} engineers for new approach, trained team on new tools, worked with DevOps team to implement infrastructure changes",
    learning_outcomes: "Mastered CI/CD best practices, learned Docker and Kubernetes orchestration, developed skills in technical strategy and team buy-in",
    goals_supported: "Enabled rapid product iteration cycles required for competitive market positioning, supported engineering efficiency and reliability OKRs"
  },
  {
    title: "Created comprehensive API documentation reducing support burden",
    description: "Authored detailed API documentation with interactive examples, reducing developer confusion and accelerating partner integrations.",
    category: 'Design & documentation',
    impact_metrics: "Reduced API-related support tickets by {percentage}%, accelerated partner integration time by 3 weeks, documentation accessed by 200+ developers monthly",
    collaboration_details: "Gathered feedback from customer success and business development teams, collaborated with technical writers, coordinated with API consumers for user testing",
    learning_outcomes: "Developed technical writing expertise, learned API design best practices, gained skills in developer experience optimization",
    goals_supported: "Supported business development goals for partner ecosystem growth, reduced customer success team workload enabling focus on strategic accounts"
  }
]

# Placeholder options
technologies = ['React', 'Vue.js', 'Angular', 'Node.js', 'Python', 'Kubernetes', 'Docker', 'GraphQL', 'TypeScript', 'PostgreSQL', 'Redis', 'MongoDB', 'Terraform', 'AWS', 'GCP']
percentages = [25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85]
numbers = (2..12).to_a
quarters = ['Q1', 'Q2', 'Q3', 'Q4']
conferences = ['DevConf', 'ReactConf', 'RubyConf', 'KubeCon', 'DockerCon', 'AWSome Day', 'PyCon', 'JSConf', 'StrangeLoop']
features = ['user dashboard', 'payment system', 'notification center', 'search functionality', 'analytics dashboard', 'mobile app', 'API gateway', 'chat system']
amounts = [50, 75, 100, 150, 200, 250, 300, 500, 750]

puts "Creating 500 realistic achievement entries with full brag doc details..."

500.times do |i|
  # Select a random template
  template = achievement_templates.sample
  
  # Helper function to replace placeholders
  def replace_placeholders(text, technologies, percentages, numbers, quarters, conferences, features, amounts)
    text = text.dup
    text.gsub!('{technology}', technologies.sample)
    text.gsub!('{percentage}', percentages.sample.to_s)
    text.gsub!('{number}', numbers.sample.to_s)
    text.gsub!('{quarter}', quarters.sample)
    text.gsub!('{conference}', conferences.sample)
    text.gsub!('{feature}', features.sample)
    text.gsub!('{amount}', amounts.sample.to_s)
    text
  end
  
  # Replace placeholders in all fields
  title = replace_placeholders(template[:title], technologies, percentages, numbers, quarters, conferences, features, amounts)
  description = replace_placeholders(template[:description], technologies, percentages, numbers, quarters, conferences, features, amounts)
  impact_metrics = replace_placeholders(template[:impact_metrics], technologies, percentages, numbers, quarters, conferences, features, amounts)
  collaboration_details = replace_placeholders(template[:collaboration_details], technologies, percentages, numbers, quarters, conferences, features, amounts)
  learning_outcomes = replace_placeholders(template[:learning_outcomes], technologies, percentages, numbers, quarters, conferences, features, amounts)
  goals_supported = replace_placeholders(template[:goals_supported], technologies, percentages, numbers, quarters, conferences, features, amounts)
  
  # Generate a random date within the last 2 years
  date = Date.current - rand(730).days
  
  user.achievements.create!(
    title: title,
    description: description,
    date: date,
    category: template[:category],
    impact_metrics: impact_metrics,
    collaboration_details: collaboration_details,
    learning_outcomes: learning_outcomes,
    goals_supported: goals_supported
  )
  
  print "." if (i + 1) % 50 == 0
end

puts "\n✅ Successfully created #{Achievement.count} achievements!"
puts "Categories distribution:"
categories.each do |cat|
  count = Achievement.where(category: cat).count
  puts "  #{cat}: #{count} achievements"
end

puts "\nSample achievement with full brag doc details:"
sample = Achievement.last
puts "Title: #{sample.title}"
puts "Category: #{sample.display_category}"
puts "Impact: #{sample.impact_metrics[0..100]}..."
puts "Collaboration: #{sample.collaboration_details[0..100]}..."

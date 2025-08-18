import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "title", "description", "impactMetrics", "collaborationDetails", "learningOutcomes", "goalsSupported"]
  
  connect() {
    this.updatePrompts()
  }
  
  categoryChanged() {
    this.updatePrompts()
  }
  
  updatePrompts() {
    const category = this.categoryTarget.value
    const prompts = this.getPromptsForCategory(category)
    
    // Update category description
    this.updateCategoryDescription(category)
    
    // Show/hide brag doc fields based on category
    this.toggleBragDocFields(category)
    
    if (prompts) {
      this.updatePlaceholders(prompts)
      this.showGuidanceTooltips(prompts)
    }
  }
  
  updateCategoryDescription(category) {
    const descriptions = {
      'Projects': 'Major projects, features, and technical initiatives you led or contributed to',
      'Leadership & Innovation': 'Leading teams, creative solutions, and driving organizational change',
      'Collaboration & mentorship': 'Helping others, mentoring, knowledge sharing, and teamwork',
      'Design & documentation': 'System design, technical documentation, and architectural decisions',
      'Problem Solving & Recognition': 'Debugging, incident response, awards, and external recognition of your work',
      'Company building': 'Process improvements, interviewing, recruiting, and organizational contributions',
      'Learning & Development': 'New skills, technologies, methodologies, and professional growth',
      'Outside of work': 'Open source, speaking, writing, and external professional activities'
    }
    
    const descriptionElement = document.getElementById('category-description')
    if (descriptionElement && descriptions[category]) {
      descriptionElement.textContent = descriptions[category]
    }
  }
  
  toggleBragDocFields(category) {
    // All categories now show brag doc fields
    const bragDocFields = document.getElementById('brag-doc-fields')
    
    if (bragDocFields) {
      bragDocFields.style.display = 'block'
      bragDocFields.classList.add('active')
    }
  }
  
  getPromptsForCategory(category) {
    const promptMap = {
      "Projects": {
        title: "e.g., Led migration of legacy system to microservices architecture",
        description: "Describe your contributions, the design decisions you made, and any scope reductions or insights that made the project successful",
        impactMetrics: "Quantify the results: reduced latency by 40%, saved $50K annually, supports 10K+ daily users, improved deployment time from 2 hours to 15 minutes",
        collaborationDetails: "Who did you work with? Did you mentor anyone? What cross-team coordination was required? How did you help others succeed?",
        learningOutcomes: "What new technologies, frameworks, or architectural patterns did you learn? How did this expand your technical expertise?",
        goalsSupported: "How did this project align with team/company OKRs? Did it support a major initiative, compliance requirement, or strategic goal?"
      },
      "Leadership & Innovation": {
        title: "e.g., Led initiative to adopt new testing framework, reducing bug reports by 60%",
        description: "Describe how you led others, drove change, or introduced creative solutions to complex problems",
        impactMetrics: "What was the measurable impact? How many people were affected? Did this improve team efficiency, product quality, or organizational capability?",
        collaborationDetails: "How did you build consensus and get buy-in? Did you mentor others through the change? What resistance did you overcome?",
        learningOutcomes: "What did you learn about leadership, change management, or innovation? How did this experience grow your skills?",
        goalsSupported: "How did this leadership/innovation work advance team goals, company strategy, or your career development?"
      },
      "Collaboration & mentorship": {
        title: "e.g., Mentored 3 junior engineers through their first major feature releases",
        description: "Describe the mentoring, knowledge sharing, or collaborative work you did to help others succeed",
        impactMetrics: "What was the outcome? How many people did you help? Did code review turnaround improve? Were team members promoted?",
        collaborationDetails: "Detail the specific ways you supported others: regular 1:1s, code reviews, documentation, internal talks, or cross-team knowledge sharing",
        learningOutcomes: "What did you learn about leadership, communication, or team dynamics? How did this improve your own skills?",
        goalsSupported: "How did this mentoring contribute to team velocity, knowledge sharing goals, or retention objectives?"
      },
      "Design & documentation": {
        title: "e.g., Wrote comprehensive API design doc for new payment system",
        description: "Describe the design challenge, your approach, and why the documentation was needed",
        impactMetrics: "How many engineers used this? Did it reduce questions/support tickets? Did it speed up implementation or onboarding?",
        collaborationDetails: "Who did you collaborate with on the design? Did you facilitate design reviews or gather stakeholder input?",
        learningOutcomes: "What did you learn about system design, documentation practices, or technical communication?",
        goalsSupported: "How did this design work support broader architecture goals, team efficiency, or engineering standards?"
      },
      "Problem Solving & Recognition": {
        title: "e.g., Resolved critical production incident affecting 50% of users, received company-wide recognition",
        description: "Describe the complex problem you solved, debugging process, or recognition you received for exceptional work",
        impactMetrics: "What was the business impact? How quickly was it resolved? What recognition did you receive and from whom?",
        collaborationDetails: "Who else was involved in the solution? How did you coordinate during the incident? Did you help others learn from it?",
        learningOutcomes: "What technical or problem-solving skills did you develop? How did this recognition validate your growth?",
        goalsSupported: "How does this demonstrate your value to the company? What does this recognition say about your career trajectory?"
      },
      "Company building": {
        title: "e.g., Improved interview process by creating structured technical assessment framework",
        description: "Describe what company-wide process, practice, or initiative you contributed to beyond your direct team",
        impactMetrics: "What was the company-wide impact? How many people were affected? Did this improve hiring, retention, or processes?",
        collaborationDetails: "Who did you work with across the company? How did you gather input and build consensus for changes?",
        learningOutcomes: "What did you learn about organizational change, process improvement, or cross-functional work?",
        goalsSupported: "How did this work support company-wide goals like scaling, culture, diversity, or operational excellence?"
      },
      "Learning & Development": {
        title: "e.g., Mastered Kubernetes orchestration and cloud-native deployment patterns",
        description: "Describe the specific skills, technologies, or knowledge areas you developed",
        impactMetrics: "How did you apply this learning? Did it improve your work quality, efficiency, or enable new capabilities?",
        collaborationDetails: "Did you share this knowledge with others? Did you become a go-to person for this area?",
        learningOutcomes: "Detail the specific competencies gained and how they complement your existing skill set",
        goalsSupported: "How does this learning align with your career goals or support team/company technical direction?"
      },
      "Outside of work": {
        title: "e.g., Gave talk at local tech meetup on distributed systems patterns",
        description: "Describe your external contributions to the tech community, open source, or professional development",
        impactMetrics: "What was the reach or impact? How many people attended/used your contribution? Any recognition received?",
        collaborationDetails: "Did you collaborate with others in the community? Did this work connect back to your team in any way?",
        learningOutcomes: "What skills did you develop through this external work? How does it make you a better engineer?",
        goalsSupported: "How does this external work enhance your professional brand or support your career advancement?"
      }
    }
    
    return promptMap[category]
  }
  
  updatePlaceholders(prompts) {
    if (this.hasTitleTarget) {
      this.titleTarget.placeholder = prompts.title
    }
    if (this.hasDescriptionTarget) {
      this.descriptionTarget.placeholder = prompts.description
    }
    if (this.hasImpactMetricsTarget) {
      this.impactMetricsTarget.placeholder = prompts.impactMetrics
    }
    if (this.hasCollaborationDetailsTarget) {
      this.collaborationDetailsTarget.placeholder = prompts.collaborationDetails
    }
    if (this.hasLearningOutcomesTarget) {
      this.learningOutcomesTarget.placeholder = prompts.learningOutcomes
    }
    if (this.hasGoalsSupportedTarget) {
      this.goalsSupportedTarget.placeholder = prompts.goalsSupported
    }
  }
  
  showGuidanceTooltips(prompts) {
    // Update form help text based on category
    const helpTexts = this.element.querySelectorAll('.form-text')
    if (helpTexts.length >= 4) {
      helpTexts[0].textContent = "Quantify the business impact and measurable results"
      helpTexts[1].textContent = "Highlight how you worked with and helped others succeed"  
      helpTexts[2].textContent = "Document the skills and knowledge you gained from this work"
      helpTexts[3].textContent = "Connect your achievement to larger organizational objectives"
    }
  }
}
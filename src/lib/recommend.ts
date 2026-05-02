/**
 * Path recommendation logic based on onboarding answers.
 * Pure function — no side effects.
 */

export type CareerGoal = 'build-products' | 'design-ux' | 'manage-teams' | 'grow-brands' | 'analyze-data'
export type ExperienceLevel = 'beginner' | 'some' | 'intermediate'

export interface OnboardingAnswers {
  careerGoal: CareerGoal
  knownTools: string[]
  likesData: boolean
  likesCode: boolean
  likesDesign: boolean
  likesStrategy: boolean
}

export interface PathRecommendation {
  pathSlug: string
  pathName: string
  reason: string
  color: string
  emoji: string
}

const PATHS: Record<string, Omit<PathRecommendation, 'reason'>> = {
  'ai-product-building': {
    pathSlug: 'ai-product-building',
    pathName: 'AI Product Building',
    color: '#6366F1',
    emoji: '🤖',
  },
  'ux-design': {
    pathSlug: 'ux-design',
    pathName: 'UX Design',
    color: '#C084FC',
    emoji: '🎨',
  },
  'product-management': {
    pathSlug: 'product-management',
    pathName: 'Product Management',
    color: '#F5C842',
    emoji: '📦',
  },
  'digital-marketing': {
    pathSlug: 'digital-marketing',
    pathName: 'Digital Marketing',
    color: '#FB923C',
    emoji: '📈',
  },
  'data-analysis': {
    pathSlug: 'data-analysis',
    pathName: 'Data Analysis',
    color: '#34D399',
    emoji: '📊',
  },
}

export function recommendPath(answers: OnboardingAnswers): PathRecommendation {
  // Direct goal mapping
  if (answers.careerGoal === 'design-ux') {
    return { ...PATHS['ux-design'], reason: 'Your goal to design intuitive products is a perfect match for the UX path.' }
  }
  if (answers.careerGoal === 'grow-brands') {
    return { ...PATHS['digital-marketing'], reason: 'Growing brands with content and ads? Digital Marketing is your lane.' }
  }
  if (answers.careerGoal === 'analyze-data') {
    return { ...PATHS['data-analysis'], reason: 'Data intuition + the tools to back it up. This path is built for you.' }
  }

  // build-products or manage-teams — use skill preferences to split
  if (answers.careerGoal === 'build-products') {
    if (answers.likesCode) {
      return { ...PATHS['ai-product-building'], reason: 'You like building things — the AI Product path will take you from idea to deployed product.' }
    }
    return { ...PATHS['product-management'], reason: 'You\'re great at spotting opportunities. PM is the role that connects all the dots.' }
  }

  // manage-teams → PM or AI depending on code leaning
  if (answers.likesCode && !answers.likesStrategy) {
    return { ...PATHS['ai-product-building'], reason: 'Your technical instincts are your superpower. Build with AI.' }
  }
  if (answers.likesDesign) {
    return { ...PATHS['ux-design'], reason: 'Your creative eye is exactly what the UX path rewards.' }
  }
  if (answers.likesData) {
    return { ...PATHS['data-analysis'], reason: 'Numbers make sense to you — Data Analysis will amplify that.' }
  }

  // Default fallback
  return { ...PATHS['product-management'], reason: 'You have the strategy mindset — Product Management will put it to work.' }
}

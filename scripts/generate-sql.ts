import * as fs from 'fs'
import * as path from 'path'
import { parse } from 'csv-parse/sync'
import crypto from 'crypto'

// Simple deterministic UUID generation based on legacy string ID
function toUUID(str: string): string {
  const hash = crypto.createHash('md5').update(str).digest('hex')
  return `${hash.slice(0, 8)}-${hash.slice(8, 12)}-4${hash.slice(13, 16)}-a${hash.slice(17, 20)}-${hash.slice(20, 32)}`
}

function extractVideoId(url: string): string | null {
  try {
    const u = new URL(url)
    if (u.hostname.includes('youtu.be')) return u.pathname.slice(1)
    const v = u.searchParams.get('v')
    if (v) return v
    if (u.searchParams.get('list') && !v) return null
    return null
  } catch {
    return null
  }
}

function slugify(text: string): string {
  return text.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '')
}

function escapeSql(str: string | null | undefined): string {
  if (!str) return 'NULL'
  return `'${str.replace(/'/g, "''")}'`
}

const PATHS = [
  { id: '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c', name: 'AI Product Building', slug: 'ai-product-building', desc: 'Build real AI products.', cat: 'AI', color: '#6366F1', order: 1 },
  { id: '1d4aeeee-79cc-4887-9e02-01a6999ceaa1', name: 'UX Design', slug: 'ux-design', desc: 'Design intuitive products.', cat: 'Design', color: '#C084FC', order: 2 },
  { id: '3275b00a-58d7-4a4b-8472-a851a9231497', name: 'Product Management', slug: 'product-management', desc: 'Lead products from 0 to 1.', cat: 'Product', color: '#F5C842', order: 3 },
  { id: '251e65a0-3e44-4a0e-b18a-78fe5d7a1366', name: 'Digital Marketing', slug: 'digital-marketing', desc: 'Grow brands with content.', cat: 'Marketing', color: '#FB923C', order: 4 },
  { id: 'f4f7844a-e0a8-47a4-bdef-83b51c933b39', name: 'Data Analysis', slug: 'data-analysis', desc: 'Turn raw data into decisions.', cat: 'Data', color: '#34D399', order: 5 },
]

const COURSE_PATH_MAP: Record<string, string> = {
  'ui-ux-design': '1d4aeeee-79cc-4887-9e02-01a6999ceaa1',
  'ux-design': '1d4aeeee-79cc-4887-9e02-01a6999ceaa1',
  'figma': '1d4aeeee-79cc-4887-9e02-01a6999ceaa1',
  'product-management': '3275b00a-58d7-4a4b-8472-a851a9231497',
  'product-strategy': '3275b00a-58d7-4a4b-8472-a851a9231497',
  'agile': '3275b00a-58d7-4a4b-8472-a851a9231497',
  'digital-marketing': '251e65a0-3e44-4a0e-b18a-78fe5d7a1366',
  'seo': '251e65a0-3e44-4a0e-b18a-78fe5d7a1366',
  'content-marketing': '251e65a0-3e44-4a0e-b18a-78fe5d7a1366',
  'social-media': '251e65a0-3e44-4a0e-b18a-78fe5d7a1366',
  'email-marketing': '251e65a0-3e44-4a0e-b18a-78fe5d7a1366',
  'data-analysis': 'f4f7844a-e0a8-47a4-bdef-83b51c933b39',
  'python': 'f4f7844a-e0a8-47a4-bdef-83b51c933b39',
  'sql': 'f4f7844a-e0a8-47a4-bdef-83b51c933b39',
  'excel': 'f4f7844a-e0a8-47a4-bdef-83b51c933b39',
  'ai': '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c',
  'machine-learning': '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c',
  'chatgpt': '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c',
  'prompt-engineering': '15d8db2d-ea90-4e85-8d2b-b42a15bf5c0c',
}

function mapCourseToPathId(courseSlug: string, courseTitle: string): string {
  const slug = courseSlug.toLowerCase()
  for (const [key, pathUUID] of Object.entries(COURSE_PATH_MAP)) {
    if (slug.includes(key) || courseTitle.toLowerCase().includes(key)) {
      return pathUUID
    }
  }
  return '251e65a0-3e44-4a0e-b18a-78fe5d7a1366'
}

function generate() {
  console.log('Generating seed-data.sql...')
  const outPath = path.join(__dirname, '..', 'seed-data.sql')
  const out = fs.createWriteStream(outPath)

  out.write('-- VibeLearn Seed Data\n')
  out.write('-- Run this script in the Supabase SQL Editor\n\n')

  // 1. Paths
  out.write('-- ================= PATHS =================\n')
  for (const p of PATHS) {
    out.write(`INSERT INTO paths (id, name, slug, description, category, hero_color, order_index, is_published) VALUES (${escapeSql(p.id)}, ${escapeSql(p.name)}, ${escapeSql(p.slug)}, ${escapeSql(p.desc)}, ${escapeSql(p.cat)}, ${escapeSql(p.color)}, ${p.order}, true) ON CONFLICT (slug) DO NOTHING;\n`)
  }

  const csvDir = path.join(__dirname, '..', '..')

  // 2. Courses
  out.write('\n-- ================= COURSES =================\n')
  const courseRaw = fs.readFileSync(path.join(csvDir, 'Course_export.csv'), 'utf-8')
  const courses = parse(courseRaw, { columns: true, skip_empty_lines: true }) as any[]
  
  const courseIds = new Set<string>()

  for (const row of courses) {
    const legacyId = row.id ?? row._id
    if (!legacyId) continue
    const courseId = toUUID(legacyId)
    courseIds.add(courseId)

    const title = row.title ?? row.name ?? ''
    const slug = row.slug ?? slugify(title)
    const desc = row.description ?? ''
    const order = parseInt(row.order ?? '0') || 0
    const pathId = mapCourseToPathId(slug, title)

    out.write(`INSERT INTO courses (id, path_id, title, slug, description, order_index) VALUES (${escapeSql(courseId)}, ${escapeSql(pathId)}, ${escapeSql(title)}, ${escapeSql(slug)}, ${escapeSql(desc)}, ${order}) ON CONFLICT DO NOTHING;\n`)
  }

  // 3. Modules
  out.write('\n-- ================= MODULES =================\n')
  const moduleRaw = fs.readFileSync(path.join(csvDir, 'Module_export.csv'), 'utf-8')
  const modules = parse(moduleRaw, { columns: true, skip_empty_lines: true }) as any[]

  const moduleIds = new Set<string>()

  // Batch insert modules
  for (const row of modules) {
    const legacyId = row.id ?? row._id
    if (!legacyId) continue
    const moduleId = toUUID(legacyId)
    
    const legacyCourseId = row.course_id ?? row.courseId
    if (!legacyCourseId) continue
    const courseId = toUUID(legacyCourseId)
    
    if (!courseIds.has(courseId)) continue // skip orphan modules
    
    moduleIds.add(moduleId)

    const title = row.title ?? row.name ?? ''
    const desc = row.description ?? ''
    const order = parseInt(row.order_index ?? row.orderIndex ?? '0') || 0

    out.write(`INSERT INTO modules (id, course_id, legacy_id, title, description, order_index) VALUES (${escapeSql(moduleId)}, ${escapeSql(courseId)}, ${escapeSql(legacyId)}, ${escapeSql(title)}, ${escapeSql(desc)}, ${order}) ON CONFLICT DO NOTHING;\n`)
  }

  // 4. Lessons
  out.write('\n-- ================= LESSONS =================\n')
  const lessonRaw = fs.readFileSync(path.join(csvDir, 'Lesson_export.csv'), 'utf-8')
  const lessons = parse(lessonRaw, { columns: true, skip_empty_lines: true }) as any[]

  let i = 0
  out.write('BEGIN;\n')
  for (const row of lessons) {
    const legacyId = row.id ?? row._id
    if (!legacyId) continue
    const lessonId = toUUID(legacyId)

    const legacyModuleId = row.module_id ?? row.moduleId
    if (!legacyModuleId) continue
    const moduleId = toUUID(legacyModuleId)

    if (!moduleIds.has(moduleId)) continue // skip orphan lessons

    const title = row.title ?? row.name ?? ''
    const url = row.youtube_url ?? row.url ?? row.link ?? ''
    const videoId = extractVideoId(url)
    const order = parseInt(row.order_index ?? row.orderIndex ?? row.order ?? '0') || 0
    const duration = parseFloat(row.duration_minutes ?? row.duration ?? '0') || null

    out.write(`INSERT INTO lessons (id, module_id, legacy_id, title, youtube_url, youtube_video_id, order_index, duration_minutes) VALUES (${escapeSql(lessonId)}, ${escapeSql(moduleId)}, ${escapeSql(legacyId)}, ${escapeSql(title)}, ${escapeSql(url)}, ${escapeSql(videoId)}, ${order}, ${duration === null ? 'NULL' : duration}) ON CONFLICT DO NOTHING;\n`)
    
    i++
    if (i % 1000 === 0) {
      out.write('COMMIT;\nBEGIN;\n')
    }
  }
  out.write('COMMIT;\n')

  out.end()
  console.log(`Successfully generated seed-data.sql with paths, courses, modules, and lessons!`)
}

generate()

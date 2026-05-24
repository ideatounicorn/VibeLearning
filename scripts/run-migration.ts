import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as fs from 'fs'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

// Split SQL into individual statements, skip comments and blanks
function parseStatements(sql: string): string[] {
  return sql
    .split(/;\s*\n/)
    .map(s => s.trim())
    .filter(s => s.length > 0 && !s.startsWith('--'))
}

async function runMigration(filePath: string) {
  const sql = fs.readFileSync(filePath, 'utf-8')
  const statements = parseStatements(sql)

  console.log(`Running ${filePath}`)
  console.log(`Found ${statements.length} statements\n`)

  let ok = 0
  let fail = 0

  for (const stmt of statements) {
    // Skip pure comment blocks
    const clean = stmt.replace(/--.*$/gm, '').trim()
    if (!clean) continue

    // Use Supabase's rpc or raw query via REST
    // Supabase JS client doesn't expose raw SQL — use fetch to the REST SQL endpoint
    const res = await fetch(`${process.env.NEXT_PUBLIC_SUPABASE_URL}/rest/v1/rpc/exec_sql`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${process.env.SUPABASE_SERVICE_ROLE_KEY}`,
        'apikey': process.env.SUPABASE_SERVICE_ROLE_KEY!,
      },
      body: JSON.stringify({ sql: clean + ';' }),
    })

    if (res.ok || res.status === 204) {
      console.log(`  ✅  ${clean.slice(0, 80).replace(/\n/g, ' ')}...`)
      ok++
    } else {
      const body = await res.text()
      // IF NOT EXISTS errors are safe — table/index already exists
      if (body.includes('already exists') || body.includes('duplicate')) {
        console.log(`  ⏭   SKIP (already exists): ${clean.slice(0, 60).replace(/\n/g, ' ')}...`)
        ok++
      } else {
        console.error(`  ❌  FAIL: ${clean.slice(0, 80).replace(/\n/g, ' ')}`)
        console.error(`       ${body.slice(0, 200)}`)
        fail++
      }
    }

    await new Promise(r => setTimeout(r, 100))
  }

  console.log(`\nDone. OK: ${ok}, Failed: ${fail}`)
  if (fail > 0) process.exit(1)
}

const target = process.argv[2] ?? 'supabase-phase5-migration.sql'
runMigration(path.join(process.cwd(), target))

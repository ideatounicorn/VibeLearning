import * as dotenv from 'dotenv'
import * as fs from 'fs'
import * as path from 'path'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const URL = process.env.NEXT_PUBLIC_SUPABASE_URL!
const KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!

async function exec(sql: string): Promise<{ ok: boolean; body?: string }> {
  const res = await fetch(`${URL}/rest/v1/rpc/exec_sql`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${KEY}`,
      apikey: KEY,
    },
    body: JSON.stringify({ sql }),
  })
  if (res.ok || res.status === 204) return { ok: true }
  return { ok: false, body: await res.text() }
}

async function main() {
  const dir = path.join(process.cwd(), 'assesments_sql', '_fixed')
  const files = fs
    .readdirSync(dir)
    .filter((f) => f.endsWith('.sql'))
    .sort()

  console.log(`Running ${files.length} assessment SQL files`)
  let ok = 0
  let fail = 0
  for (const f of files) {
    const sql = fs.readFileSync(path.join(dir, f), 'utf-8')
    process.stdout.write(`  ${f} ... `)
    const r = await exec(sql)
    if (r.ok) {
      console.log('OK')
      ok++
    } else {
      console.log('FAIL')
      console.error(r.body?.slice(0, 400))
      fail++
    }
  }
  console.log(`\nDone. OK: ${ok}, Fail: ${fail}`)
  process.exit(fail > 0 ? 1 : 0)
}

main().catch((e) => {
  console.error(e)
  process.exit(1)
})

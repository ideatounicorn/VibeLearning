import { Resend } from 'resend'

const FROM_EMAIL = 'hey@vibelearn.app'

function getResend() {
  if (!process.env.RESEND_API_KEY) return null
  return new Resend(process.env.RESEND_API_KEY)
}

export async function sendWelcomeEmail(to: string, name: string) {
  try {
    const resend = getResend()
    if (!resend) return
    await resend.emails.send({
      from: `VibeLearn <${FROM_EMAIL}>`,
      to,
      subject: 'Welcome to VibeLearn. Let\'s build your path.',
      html: `
        <div style="font-family: sans-serif; color: #1a1a1a;">
          <h2>Hey ${name || 'there'},</h2>
          <p>Welcome to VibeLearn. We built this because we were tired of endless YouTube tutorials that lead nowhere.</p>
          <p>Here, every video has a purpose, every module has a quiz, and every path leads to a specific career goal.</p>
          <p><strong>Your next step:</strong> Pick your learning path and complete your first module. (We'll give you 10 XP just for watching the first video).</p>
          <p><a href="https://vibelearn.app/dashboard">Go to your dashboard →</a></p>
          <p>Best,<br>The VibeLearn Team</p>
        </div>
      `,
    })
  } catch (error) {
    console.error('Failed to send welcome email:', error)
  }
}

export async function sendStreakNudge(to: string, streakDays: number) {
  try {
    const resend = getResend()
    if (!resend) return
    await resend.emails.send({
      from: `VibeLearn <${FROM_EMAIL}>`,
      to,
      subject: `Don't break your ${streakDays}-day streak! 🔥`,
      html: `
        <div style="font-family: sans-serif; color: #1a1a1a;">
          <h2>You're on fire! 🔥</h2>
          <p>You've built a solid ${streakDays}-day learning streak. Don't let it slip now.</p>
          <p>Complete just one lesson today to keep your streak alive and earn your daily XP.</p>
          <p><a href="https://vibelearn.app/dashboard">Keep learning →</a></p>
        </div>
      `,
    })
  } catch (error) {
    console.error('Failed to send streak nudge:', error)
  }
}

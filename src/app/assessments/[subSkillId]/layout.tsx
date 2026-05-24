export const metadata = {
  title: 'Assessment Test — VibeLearn',
}

export default function AssessmentLayout({ children }: { children: React.ReactNode }) {
  return (
    // We force a light theme for the assessment experience and hide the normal sidebar by 
    // wrapping it in a fixed full-screen absolute container.
    // In next-themes, we can override by passing a specific class or just using styles.
    <div className="fixed inset-0 z-[9999] bg-white overflow-hidden text-black light">
      <style dangerouslySetInnerHTML={{__html: `
        :root {
          color-scheme: light !important;
        }
      `}} />
      {children}
    </div>
  )
}

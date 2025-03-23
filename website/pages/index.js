import { useState } from 'react'
import Head from 'next/head'
import Link from 'next/link'
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter'
import { atomDark } from 'react-syntax-highlighter/dist/cjs/styles/prism'
import { getConfigFiles } from '../lib/files'

export default function Home({ hosts, commonFiles }) {
  const [selectedHost, setSelectedHost] = useState(null)
  const [selectedFile, setSelectedFile] = useState(null)

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <Head>
        <title>NixOS Configurations</title>
        <meta name="description" content="My NixOS dotfiles and configurations" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <nav className="bg-gray-800 p-4">
        <div className="container mx-auto flex justify-between items-center">
          <h1 className="text-2xl font-bold">NixOS Configs</h1>
          <div className="flex space-x-4">
            <Link href="https://github.com/Rishabh5321/dotfiles" className="hover:text-gray-300">
              GitHub
            </Link>
          </div>
        </div>
      </nav>

      <main className="container mx-auto py-8 px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <div className="md:col-span-1 bg-gray-800 p-4 rounded-lg">
            <h2 className="text-xl font-bold mb-4">Hosts</h2>
            <ul className="space-y-2">
              {hosts.map((host) => (
                <li key={host.name}>
                  <button
                    onClick={() => {
                      setSelectedHost(host)
                      setSelectedFile(null)
                    }}
                    className={`w-full text-left p-2 rounded ${
                      selectedHost?.name === host.name ? 'bg-blue-700' : 'hover:bg-gray-700'
                    }`}
                  >
                    {host.name}
                  </button>
                  {selectedHost?.name === host.name && (
                    <ul className="pl-4 mt-2 space-y-1">
                      {host.files.map((file) => (
                        <li key={file.path}>
                          <button
                            onClick={() => setSelectedFile(file)}
                            className={`w-full text-left p-1 rounded text-sm ${
                              selectedFile?.path === file.path
                                ? 'bg-blue-600'
                                : 'hover:bg-gray-700'
                            }`}
                          >
                            {file.name}
                          </button>
                        </li>
                      ))}
                    </ul>
                  )}
                </li>
              ))}
            </ul>

            <h2 className="text-xl font-bold mt-6 mb-4">Common Files</h2>
            <ul className="space-y-1">
              {commonFiles.map((file) => (
                <li key={file.path}>
                  <button
                    onClick={() => {
                      setSelectedHost(null)
                      setSelectedFile(file)
                    }}
                    className={`w-full text-left p-2 rounded text-sm ${
                      selectedFile?.path === file.path ? 'bg-blue-700' : 'hover:bg-gray-700'
                    }`}
                  >
                    {file.name}
                  </button>
                </li>
              ))}
            </ul>
          </div>

          <div className="md:col-span-3">
            {selectedFile ? (
              <div className="bg-gray-800 p-4 rounded-lg">
                <div className="flex justify-between items-center mb-4">
                  <h2 className="text-xl font-bold">{selectedFile.path}</h2>
                  <a
                    href={`https://github.com/Rishabh5321/dotfiles/blob/main/${selectedFile.path}`}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-blue-400 hover:text-blue-300"
                  >
                    View on GitHub
                  </a>
                </div>
                <SyntaxHighlighter
                  language="nix"
                  style={atomDark}
                  showLineNumbers
                  className="rounded"
                >
                  {selectedFile.content}
                </SyntaxHighlighter>
              </div>
            ) : (
              <div className="bg-gray-800 p-6 rounded-lg">
                <h2 className="text-2xl font-bold mb-4">NixOS Configuration</h2>
                <p className="mb-4">
                  This website showcases my NixOS configurations for various hosts:
                </p>
                <ul className="list-disc pl-6 mb-6 space-y-2">
                  {hosts.map((host) => (
                    <li key={host.name}>
                      <strong>{host.name}</strong>: {host.description || 'NixOS configuration'}
                    </li>
                  ))}
                </ul>
                <p>
                  Select a host from the sidebar to explore its configuration files, or check out the
                  common files used across all systems.
                </p>
              </div>
            )}
          </div>
        </div>
      </main>

      <footer className="bg-gray-800 p-4 mt-8">
        <div className="container mx-auto text-center">
          <p>
            Created with Next.js and deployed via GitHub Actions. View the source on
            <a
              href="https://github.com/Rishabh5321/dotfiles"
              className="text-blue-400 hover:text-blue-300 ml-1"
            >
              GitHub
            </a>
            .
          </p>
        </div>
      </footer>
    </div>
  )
}

export async function getStaticProps() {
  const { hosts, commonFiles } = await getConfigFiles()
  return {
    props: {
      hosts,
      commonFiles,
    },
  }
}
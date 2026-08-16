module.exports = {
  apps: [
    {
      name: "dspace-angular",
      cwd: "/home/usuario/dspace-structure/dspace-angular",
      script: "npm",
      args: "run serve:ssr",
//      node_args: "--max-old-space-size=8096",
      env: {
        NODE_ENV: "production",
      }
    }
  ]
}

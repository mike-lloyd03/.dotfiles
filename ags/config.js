const entry = App.configDir + "/main.ts";
const outdir = "/tmp/ags/js";

try {
  await Utils.execAsync([
    "esbuild",
    "--bundle",
    entry,
    "--format=esm",
    `--outfile=${outdir + "/" + "main.js"}`,
    "--external:resource://*",
    "--external:gi://*",
    "--external:file://*",
  ]);
  await import(`file://${outdir + "/" + "main.js"}`);
} catch (error) {
  console.error(error);
  App.quit();
}

export {};

module.exports = async (req, res) => {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Método no permitido' });
  let body = req.body || {};
  if (typeof body === 'string') { try { body = JSON.parse(body); } catch (e) { body = {}; } }
  const { id, data, key, check } = body;
  if (!process.env.EDIT_KEY || key !== process.env.EDIT_KEY) return res.status(401).json({ error: 'Clave incorrecta' });
  if (check) return res.status(200).json({ ok: true });
  if (!/^t\d{2}$/.test(id || '') || !data || typeof data !== 'object') return res.status(400).json({ error: 'Datos inválidos' });
  const sk = process.env.SUPABASE_SERVICE_KEY;
  const r = await fetch(process.env.SUPABASE_URL + '/rest/v1/reestr_temas?on_conflict=id', {
    method: 'POST',
    headers: Object.assign({ apikey: sk, 'Content-Type': 'application/json', Prefer: 'resolution=merge-duplicates,return=minimal' }, sk.startsWith('sb_') ? {} : { Authorization: 'Bearer ' + sk }),
    body: JSON.stringify({ id, data, updated_at: new Date().toISOString() })
  });
  if (!r.ok) return res.status(500).json({ error: await r.text() });
  return res.status(200).json({ ok: true });
};

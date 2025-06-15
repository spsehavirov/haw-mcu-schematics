# Schéma signálové cesty – od hlasu k reproduktoru

![Signálová cesta](dist/png/signal_path_flat.png)

Tento diagram znázorňuje kompletní cestu zpracování zvuku:

1. **Zvukové vlny** (ZVUKOVÉ VLNY) vycházejí z úst mluvčího (vlevo).
2. **Mikrofon** zachytí vlny a převede je na **analogové elektrické napětí** (ELEKTRICKÉ NAPĚTÍ).
3. **ADC (Analogově-digitální převodník)** převede analogový signál na digitální.
4. **DSP (Digitální signálový procesor)** digitální signál dále zpracuje (např. filtruje, komprimuje).
5. Zpracovaný signál může být **uložen** do paměti (ULOŽIŠTĚ).
6. **DAC (Digitálně-analogový převodník)** převede signál zpět na analogový.
7. **Reproduktor** vyzáří signál jako **zvukové vlny**, které slyší posluchač (vpravo).

Středová část schématu (orámovaný blok) představuje procesy, které probíhají **uvnitř počítače nebo digitálního zařízení** (_UVNITŘ POČÍTAČE_).

---

## 📁 Výstupní formáty

Diagram je automaticky generován do složky `dist/` ve formátech:

- `dist/pdf/signal_path.pdf`
- `dist/png/signal_path.png` – průhledné pozadí
- `dist/png/signal_path_flat.png` – bílé pozadí
- `dist/svg/signal_path.svg` – vektorová verze

---

## 🛠 Jak sestavit diagram

Pro sestavení diagramu stačí použít `make`:

```bash
make        # vygeneruje PDF, PNG, SVG
make clean  # smaže složku dist/
